from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index2.html')

@app.route('/send_message', methods=['POST'])
def send_message():
    user_message = request.form['user_message']

    # Aquí puedes procesar el mensaje del usuario y generar la respuesta del chatbot
    # Por ahora, devolvemos un mensaje de ejemplo
    bot_response = "Esta es la respuesta del chatbot"

    return jsonify({'response': bot_response})

if __name__ == '__main__':
    app.run()
