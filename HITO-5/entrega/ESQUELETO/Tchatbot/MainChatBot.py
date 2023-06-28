import nltk #LIBRERIA 1
from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()

import numpy
import tflearn
import tensorflow
import json
import random


#nltk.download("punkt") #descargar el modelo de lenguaje

with open("contenido.json", encoding='utf-8') as archivo:  #abrimos el archivo .json ya que ahi se encuentran respuestas predeterminadas a ciertas preguntas
    datos = json.load(archivo)

    palabras = []
    tags = []
    aux_X1 = []
    aux_Y2 = []


for contenido in datos["Contenido"]:
    for patrones in contenido["Patrones"]:
        auxPalabra = nltk.word_tokenize(patrones)
        palabras.extend(auxPalabra)
        aux_X1.append(auxPalabra)
        aux_Y2.append(contenido["tag"])

        if contenido["tag"] not in tags:
            tags.append(contenido["tag"])

palabras = [stemmer.stem(w.lower()) for w in palabras if w != "?"]
palabras = sorted (list(set(palabras)))
tags = sorted(tags)

train = []
salida = []
salidaOut = [0 for _ in range(len(tags))]


for x, documento in enumerate(aux_X1):
    cubeta = []
    palabra_aux = [stemmer.stem(w.lower()) for w in documento]
    for w in palabras:
        if w in palabra_aux:
            cubeta.append(1)
        else:
            cubeta.append(0)

    fila_salida = salidaOut[:]
    fila_salida[tags.index(aux_Y2[x])] = 1
    train.append(cubeta)
    salida.append(fila_salida)

train = numpy.array(train)
salida = numpy.array(salida)

print(train)
print(salida)

#AREA DE LA RED NEURONAL

tensorflow.compat.v1.reset_default_graph()

red_neuronal = tflearn.input_data(shape=[None, len(train[0])])

red_neuronal = tflearn.fully_connected(red_neuronal, 30)
red_neuronal = tflearn.fully_connected(red_neuronal, 30)


red_neuronal = tflearn.fully_connected(red_neuronal, len(salida[0]),activation="softmax")

red = tflearn.regression(red_neuronal)

modelo = tflearn.DNN(red_neuronal)
modelo .fit(train, salida, n_epoch=400, batch_size=32, show_metric=True) #REVISAR EL BATCH_SIZE, segun la acntidad de palabras en los patrones varia su cantidad
modelo.save("modelo.tflearn")

"""

def mainBot():
    while True:
        entrada = input("Tu: ")

        if entrada == "terminar":
            break

        cubeta = [0 for _ in range(len(palabras))]
        entradaProcess = nltk.word_tokenize(entrada)
        entradaProcess = [stemmer.stem(palabra.lower()) for palabra in entradaProcess]
        for palabra_individual in entradaProcess:
            for i, palabra in enumerate(palabras):
                if palabra == palabra_individual:
                    cubeta[i] = 1
        resp = modelo.predict([numpy.array(cubeta)])
        resp_indice = numpy.argmax(resp)
        tag = tags[resp_indice]


        for tag_Aux in datos["Contenido"]:
            if tag_Aux["tag"] == tag:
                resp = tag_Aux["Respuestas"]

        print(f"Bot: ",random.choice(resp))
mainBot()





















"""
def get_response(msg):
    while True:
        cubeta = [0 for _ in range(len(palabras))]
        entradaProcesada = nltk.word_tokenize(msg)
        entradaProcesada = [stemmer.stem(palabra.lower()) for palabra in entradaProcesada]
        for palabraIndividual in entradaProcesada:
            for i,palabra in enumerate(palabras):
                if palabra == palabraIndividual:
                    cubeta[i]=1
        resultados = modelo.predict([numpy.array(cubeta)])
        resultadosIndices = numpy.argmax(resultados)
        tag = tags[resultadosIndices]

        for tagAux in datos ["Contenido"]:
            if tagAux["tag"] == tag:
                respuesta = tagAux ["Respuestas"]
                answer = random.choice(respuesta)
                return answer


if __name__ == "__main__":
    print("Let's chat! (type 'quit' to exit)")
    while True:
        # sentence = "do you use credit cards?"
        sentence = input("You: ")
        if sentence == "quit":
            break

        resp = get_response(sentence)
        print(resp)
