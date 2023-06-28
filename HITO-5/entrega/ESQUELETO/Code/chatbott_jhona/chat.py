class Chatbot:
    def __init__(self):
        self.responses = {
            "hola": "¡Hola! ¿En qué puedo ayudarte?",
            "adios": "¡Hasta luego!",
            "estructura for": "La estructura 'for' se utiliza para iterar sobre una secuencia o colección de elementos en un número específico de repeticiones.",
            "estructura if": "La estructura 'if' se utiliza para tomar decisiones basadas en una condición. Permite ejecutar cierto bloque de código si se cumple la condición.",
            "estructura while": "La estructura 'while' se utiliza para repetir un bloque de código mientras se cumpla una condición. La condición se verifica antes de ejecutar cada iteración.",
            "estructura do while": "La estructura 'do-while' es similar a 'while', pero la condición se verifica después de ejecutar cada iteración. Esto garantiza que el bloque de código se ejecute al menos una vez.",
            "crear clase": "Para crear una clase en Java, se utiliza la palabra clave 'class' seguida del nombre de la clase. Puedes definir atributos y métodos dentro de la clase para representar propiedades y comportamientos específicos.",
        }
    
    def generate_response(self, message):
        message = message.lower()
        response = self.responses.get(message, "Lo siento, no entiendo tu mensaje")
        return response

# Crear una instancia del chatbot
chatbot = Chatbot()

# Simular una conversación
while True:
    user_input = input("Usuario: ")
    response = chatbot.generate_response(user_input)
    print("Chatbot:", response)
    print()
