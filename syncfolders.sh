

file1='/home/danmar/Documentos/SistemasInformaticos'
file2='/home/danmar/Documentos/SistemasInformaticosBackup'

filedate1=$(stat -c "%Y" $file1)
filedate2=$(stat -c "%Y" $file2)

if [ "$1" = -i ]
then

	echo $file1
	echo $file2

	echo $filedate1
	echo $filedate2
fi

if [ $filedate1 -gt $filedate2 ];then
	rsync -a $file1/ $file2/

	echo "Sistemas Informaticos -> Sistemas Informaticos Backup"
elif [ $filedate1 -eq $filedate2 ]
then
	echo "No hay cambios a realizar"
else
	rsync -a $file2/ $file1/

	echo "Sistemas Informaticos Backup -> Sistemas Informaticos"
fi

exit 0

