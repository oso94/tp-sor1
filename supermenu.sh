#!/bin/bash
#------------------------------------------------------
# PALETA DE COLORES
#------------------------------------------------------
#setaf para color de letras/setab: color de fondo
	red=`tput setaf 1`;
	green=`tput setaf 2`;
	blue=`tput setaf 4`;
	bg_blue=`tput setab 4`;
	reset=`tput sgr0`;
	bold=`tput setaf bold`;
#------------------------------------------------------
# VARIABLES GLOBALES
#------------------------------------------------------
proyectoActual="/home/fedeatanasoff/Documentos/tp";
proyectos="/home/fedeatanasoff/Documentos/tp/repos.txt";

#------------------------------------------------------
# DISPLAY MENU
#------------------------------------------------------
imprimir_menu () {
       imprimir_encabezado "\t  S  U  P  E  R  -  M  E  N U ";
	
    echo -e "\t\t El proyecto actual es:";
    echo -e "\t\t $proyectoActual";
    
    echo -e "\t\t";
    echo -e "\t\t Opciones:";
    echo "";
    echo -e "\t\t\t a.  Ver estado del proyecto";
    echo -e "\t\t\t b.  Guardar cambios";
    echo -e "\t\t\t c.  Actualizar repo";
    echo -e "\t\t\t d.  Cambiar proyecto";        
    echo -e "\t\t\t e.  Agregar proyecto nuevo";        
    echo -e "\t\t\t q.  Salir";
    echo "";
    
}


 imprimir_opcion_b (){
	echo -e "\t\t";
	echo -e "\t\t Elija un comando a ejecutar:";
	echo "";
	echo -e "\t\t\t a. git add -A ";
	echo -e "\t\t\t b. git commit -m "mensaje" ";
    	echo -e "\t\t\t c. git push ";
	echo -e "\t\t\t q. Salir";
    	echo "";
    	echo -e "Escriba la opción y presione ENTER";
}

agregarMensaje () {
echo -e "\t Agregue descripcion/mensaje.";
read respuesta;
decidir "cd $proyectoActual; git commit -m $respuesta" ;
}

#------------------------------------------------------
# FUNCTIONES AUXILIARES
#------------------------------------------------------

imprimir_encabezado () {
    clear;
    #Se le agrega formato a la fecha que muestra
    #Se agrega variable $USER para ver que usuario está ejecutando
    echo -e "`date +"%d-%m-%Y %T" `\t\t\t\t\t USERNAME:$USER";
    echo "";
    #Se agregan colores a encabezado
    echo -e "\t\t ${bg_blue} ${red} ${bold}--------------------------------------\t${reset}";
    echo -e "\t\t ${bold}${bg_blue}${red}$1\t\t${reset}";
    echo -e "\t\t ${bg_blue}${red} ${bold} --------------------------------------\t${reset}";
    echo "";
}

esperar () {
    echo "";
    echo -e "Presione enter para continuar";
    read ENTER ;
}

malaEleccion () {
    echo -e "Selección Inválida ..." ;
}

decidir () {
	echo $1;
	while true; do
		echo "desea ejecutar? (s/n)";
    		read respuesta;
    		case $respuesta in
        		[Nn]* ) break;;
       			[Ss]* ) eval $1
				break;;
        		* ) echo "Por favor tipear S/s ó N/n.";;
    		esac
	done
}

#------------------------------------------------------
# FUNCIONES del MENU
#------------------------------------------------------
a_funcion () {
    	imprimir_encabezado "\tOpción a.  Ver estado del proyecto";
    	decidir "cd $proyectoActual; git status";
}

b_funcion () {
       	imprimir_encabezado "\tOpción b.  Guardar cambios";
while true;
do	

    # muestra las opciones
    imprimir_opcion_b;
    read opB;
    
    case $opB in
        a|A) decidir  "cd $proyectoActual; git add -A";;
        b|B) agregarMensaje;;
        c|C) decidir  "cd $proyectoActual; git push -u origin master";;
        q|Q) break;;
        *) malaEleccion;;
    esac
done
 
}

c_funcion () {
      	imprimir_encabezado "\tOpción c.  Actualizar repo";
	echo -e "Ingrese la nueva ruta";
	read rut
	echo $rut>> $proyectos;
	echo -e "Actualizar repositorio";
      	decidir "cd $proyectoActual; git pull";
}

d_funcion () {
	imprimir_encabezado "\tOpción d.  Cambiar proyecto";
    cont=0
    while read line
    do
        let cont+=1
       echo -e $cont"-" "$line\n";
     done < $proyectos
    
    echo -e "Elija una ruta:";
    read opC;

        cont=0
    while read line
    do
      let cont+=1
      if [ $cont == $opC ]; then
            proyectoActual=$line;
      fi
        done < $proyectos

}

e_funcion () {
	imprimir_encabezado "\tOpción e.  Agregar proyecto nuevo";        
	git clone https://gitlab.com/Gabbiani/TP1.git
        cd TP1	
	touch README.md
	git add README.md
	git commit -m "add README"
	git push -u origin master
	}
#------------------------------------------------------
# LOGICA PRINCIPAL
#------------------------------------------------------
while  true
do
    # 1. mostrar el menu
    imprimir_menu;
    # 2. leer la opcion del usuario
    read opcion;
    
    case $opcion in
        a|A) a_funcion;;
        b|B) b_funcion;;
        c|C) c_funcion;;
        d|D) d_funcion;;
        e|E) e_funcion;;
        q|Q) break;;
        *) malaEleccion;;
    esac
    esperar;
done
 
