#include <stdlib.h>
#include <stdio.h>
#include "utils.h"
#include "data.h"
#include "func.h"

/*
int main(int argc, char *argv[]) {
	char driver[NAME_LENGTH];
	char rootDirPath[NAME_LENGTH];
	char srcFilePath[NAME_LENGTH];
	char destDirPath[NAME_LENGTH];
	char destFilePath[NAME_LENGTH];

	stringCpy("fs.bin", driver, NAME_LENGTH - 1);
	stringCpy("/", rootDirPath, NAME_LENGTH - 1);
	stringCpy("./test", srcFilePath, NAME_LENGTH - 1);
	stringCpy("/doc", destDirPath, NAME_LENGTH - 1);
	stringCpy("/doc/test", destFilePath, NAME_LENGTH - 1);
	
	format(driver, SECTOR_NUM, SECTORS_PER_BLOCK);
	mkdir(driver, destDirPath);
	ls(driver, rootDirPath);
	cp(driver, srcFilePath, destFilePath);
	ls(driver, destDirPath);
	ls(driver, destFilePath);
	//cat(driver, destFilePath);
	rm(driver, destFilePath);
	ls(driver, destDirPath);
	ls(driver, rootDirPath);
	rmdir(driver, destDirPath);
	ls(driver, rootDirPath);

	return 0;
}
*/

int main(int argc, char *argv[]) {
	char driver[NAME_LENGTH];
	char srcFilePath[NAME_LENGTH];
	char destFilePath[NAME_LENGTH];

	stringCpy("fs.bin", driver, NAME_LENGTH - 1);
	format(driver, SECTOR_NUM, SECTORS_PER_BLOCK);

	stringCpy("/boot", destFilePath, NAME_LENGTH - 1);
	mkdir(driver, destFilePath);
	stringCpy(argv[1], srcFilePath, NAME_LENGTH - 1);
	stringCpy("/boot/initrd", destFilePath, NAME_LENGTH - 1);
//	touch(driver, destFilePath);
	cp(driver, srcFilePath, destFilePath);
//	touch(driver, destFilePath);	
	
	stringCpy("/dev", destFilePath, NAME_LENGTH - 1);
	mkdir(driver, destFilePath);
	stringCpy("/dev/stdin", destFilePath, NAME_LENGTH - 1);
	touch(driver, destFilePath);
	stringCpy("/dev/stdout", destFilePath, NAME_LENGTH - 1);
	touch(driver, destFilePath);

	stringCpy("/usr", destFilePath, NAME_LENGTH - 1);
	mkdir(driver, destFilePath);
	
	return 0;
}
