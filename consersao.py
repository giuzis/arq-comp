import re

#Opcodes
addi = "0001"
add = "0101"
sub = "1000"
cmp = "1001"
mov = "0100"
jeq = "001001"
jne = "001000"
jc = "001011"
jnc = "001010"
jn = "001100"
jmp = "001111"

def lista_de_palavras(instrucao):
	instrucao = instrucao.replace(","," ")
	instrucao = instrucao.split()
	

entrada = open("primo.txt",'r')
saida = open("codificacao_primo.txt",'w')

instrucoes = entrada.readlines()

for instrucao in instrucoes:



