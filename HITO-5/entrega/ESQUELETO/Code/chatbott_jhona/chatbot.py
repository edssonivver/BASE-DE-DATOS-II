from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/send_message', methods=['POST'])
def send_message():
    user_message = request.form['user_message']

    # Procesar el mensaje del usuario
    if user_message.lower() == 'hola':
        bot_response = "¡Hola! ¿En qué puedo ayudarte?"
    elif user_message.lower() == 'adios':
        bot_response = "¡Adiós! ¡Que tengas un buen día!"
    else:
        bot_response = "Lo siento, no entiendo tu mensaje."

    return {'response': bot_response}

if __name__ == '__main__':
    app.run()


