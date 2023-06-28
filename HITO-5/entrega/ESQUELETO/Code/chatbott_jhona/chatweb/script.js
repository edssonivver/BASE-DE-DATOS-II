function sendMessage() {
    var userInput = document.getElementById("chat-input").value;
    var userMessage = document.createElement("div");
    userMessage.className = "message user-message";
    userMessage.textContent = userInput;
    document.getElementById("user-message").appendChild(userMessage);
    document.getElementById("chat-input").value = "";

    // Simulación de respuesta del bot
    setTimeout(function() {
        var botMessage = document.createElement("div");
        botMessage.className = "message bot-message";
        botMessage.textContent = generateBotResponse(userInput);
        document.getElementById("user-message").appendChild(botMessage);
    }, 1000);
}

function generateBotResponse(userInput) {
    //aqui se agrega datos de respuesta con la siguiente sintaxis: "pregunta":"respuesta",
    var keywordResponses = {
        "menu": "Preguntas que puede realizar: \n1) INTERNACIONALÍZATE \n2) CONOCE TU NUEVO PORTAL ESTUDIANTIL \n3) EXPERIENCIA ACADÉMICA \n4) VIDA UNIVERSITARIA\n5) SEGURIDAD E HIGIENE \n6) INTERACCIÓN Y APOYO ESTUDIANTIL",
        "hola": "¡Hola! Soy un bot de preguntas frecuentes realizadas. Pregúntame cualquier cosa relacionada con la universidad escribiendo menu y trataré de ayudarte.",
        "adios": "¡Hasta luego!",

        //seccion 1
        "internacionalizate": "Realize una de las siguientes preguntas: \n¿Cuándo inicia el periodo de Postulación de Internacionalízate? \nLlegando a mi Intercambio, ¿tendré que estar 10 días en aislamiento? \n ¿Para irme de Intercambio dentro del Programa Internacionalízate se requiere estar vacunado?",
        "1i": "Mantente informado a través del siguiente link: https://rrii.unifranz.edu.bo/ ",
        "2i": "Todo depende de la normativa de las autoridades de salud del país de destino.Se recomienda estar en constante comunicación con el Coordinador de Movilidad Internacional de tu sede",
        "3i": "Las indicaciones sobre cómo realizar tu viaje a tu destino las establece cada país y la universidad anfitriona. La mayoría de los países exigen una prueba PCR antes de viajar y hay algunos que establecen requisitos adicionales.Es necesario consultar continuamente las páginas oficiales de la aerolínea, la embajada del país de tu destino y la universidad anfitriona.",
        //seccion 2
        "conoce tu nuevo portal estudiantil": "realize una de las sigiuentes preguntas: \n¿Cuál es la dirección del Portal Estudiantil?\n¿Quieres saber cómo ingresar al Portal Estudiantil?\n¿Cómo restablecer tu contraseña del Portal Estudiantil?\n¿Cómo visualizar tus horarios este semestre?\n¿Quieres saber cómo ver tus calificaciones?\n¿Cómo actualizar tus datos en el Portal Estudiantil?\n ¿Cuáles es el número de contacto de la universidad?",
        "1b": "Para acceder a tu nuevo Portal Estudiantil, ingresa al siguiente enlace: https://sm-portal-unf.thesiscloud.com/ Puedes ver el siguiente tutorial para conocer más sobre el Portal: https://youtu.be/O31R5g5GVOs",
        "2b": "Para ingresar al nuevo Portal Estudiantil, revisa el siguiente tutorial: https://youtu.be/OdLCmmdhpdM",
        "3b": "Ingresa al siguiente enlace para ver como restablecer tu contraseña del Portal Estudiantil: https://youtu.be/GDSXApqqaLU",
        "4b": "Para visualizar tus horarios, por favor revisa el siguiente tutorial: https://youtu.be/gI1syujYpTc",
        "5b": "Para visualizar tus horarios, por favor revisa el siguiente tutorial: https://youtu.be/gI1syujYpTc",
        "6b": "Para actualizar tus datos en el portal estudiantil, ingresa al siguiente enlace: https://youtu.be/0SbZYLpDkcc",
        "7b": "No dudes en escribirnos por WhatsApp al 71502211",
        //seccion 3 

        "experiencia academica": "Realize una de las siguientes preguntas: \n¿Cuál es el calendario de clases presenciales?\n¿Cuántos días presenciales se irá al campus?\n¿Cuál será el tamaño de los grupos presenciales?\n¿Habrá opción de cursar el semestre 100% en línea para quien así lo desee?\n¿Qué pasará si hay un brote del virus en la ciudad y/o el campus?\n¿Los estudiantes antiguos que actualmente se han inscrito ya tiene materias asignadas?\n¿Cómo es el proceso de asignación de materias el semestre I 2023?\nSoy estudiante antiguo. Ya realicé el pago. Y aún no tengo la asignación de mis materias en mi Portal Estudiantil, ¿Qué debo hacer?",
        "1c": "Las clases presenciales que tengas estarán en función a los horarios de tus asignaturas Consulta tu Portal Estudiantil: https://sm-portal-unf.thesiscloud.com/",
        "2c": "Todo el semestre es presencial excepto para las asignaturas nacionales.",
        "3c": "Eltamaño de los grupos presenciales depende del tamaño de las aulas donde curses tus asignaturas y los protocolos vigentes de bioseguridad.",
        "4c": "Si bien algunas asignaturas serán virtuales, no existe la opción de cursar 100% del semestre en línea.",
        "5c": "UNIFRANZ prevé la posibilidad de que alternemos de la presencialidad a lo remoto en caso necesario, siempre privilegiando la salud y la seguridad de nuestra comunidad. Conoce lo protocolos de bioseguridad en el siguiente enlace: https://retornoseguro.unifranz.edu.bo/protocolos-de-bioseguridad",
        "6c": "Una vez que hayas realizado el pago de tu primera mensualidad, en 24 hrs. podrás ver la asignación de tus materias con los horarios respectivos en tu Portal Estudiantil.",
        "7c": "El proceso de asignación de materias es el mismo del semestre pasado. Una vez realizado el pago de la primera mensualidad se procederá a la asignación en 24 horas y la podrás ver en tu Portal Estudiantil bajo la premisa de optimizar tu tiempo como estudiante.Si tienes alguna consulta adicional sobre tus horarios, pregunta a tu director de Carrera.",
        "8c": "El proceso de asignación de materias se realiza de manera gradual desde el 30 de enero. Recuerda, una vez realizado el pago de tu primera cuota, pasada esta fecha, debes esperar 24 horas para visualizar tu asignación de materias en tu Portal Estudiantil.",


        //SECCION 4 -----------------------------------------------------------


        "VIDA UNIVERSITARIA": "Realize una de las siguientes preguntas \n¿Cuántos días presenciales se irá al Campus?\n¿Cuál será el tamaño de los grupos presenciales?\n¿Cómo se tiene previsto desarrollar los Proyecto Integradores y Menciones de Especialización?\nEn las actividades deportivas, ¿podremos tener contacto físico?\n¿Cómo se tiene previsto el desarrollo de las prácticas presenciales?",
        "1d": "Dependerá del horario asignado y las actividades programadas para cada asignatura que debas cursar. Las actividades programadas serán comunicadas por el profesor al inicio de clases.",
        "2d": "El tamaño de los grupos presenciales estará en función de las normas de bioseguridad establecidas por el estado. ",
        "3d": "Los proyectos integradores son asignaturas prácticas por lo que requerirán la presencialidad. Las menciones obedecerán a las actividades programadas en los Diseños Instruccionales. Las actividades serán comunicadas por el profesor al inicio de clases. ",
        "4d": "Las actividades disponibles en cada campus han sido diseñadas cumpliendo con los más estrictos estándares que maximizan el cuidado de todos.",
        "5d": "Las prácticas presenciales requerirán el uso de los laboratorios en instalaciones de la universidad respetando las medidas de distanciamiento establecidas por el Estado.",


        //seccion 5 y 6
        "seguridad e higiene": "Realize una de las siguientes preguntas\n¿Cuáles son las medidas sanitarias en personas totalmente vacunadas?\n¿Los estudiantes vulnerables o que se encuentren atravesando la enfermedad del Virus COVID 19 deben asistir a las actividades presenciales?\n¿Cómo van a asegurar que todos los estudiantes y los administrativos tomen las medidas de bioseguridad?\n¿Qué pasa con los espacios en Biblioteca y las cafeterías?\n¿Cómo se garantiza la ventilación de espacios cerrados?",
        "1e": "Dado que el virus está aún latente, y las vacunas no evitan los contagios ni que existan personas portadoras, las medidas de bioseguridad son las mismas; Lavado de manos permanente, distanciamiento social, evitar aglomeraciones y observar todas las recomendaciones de la señalética instalada en la Universidad.",
        "2e": "Bajo consentimiento informado, y cumpliendo con las medidas de bioseguridad implementadas en la Universidad no pueden asistir a actividades presenciales hasta no pasar la enfermedad y dar negativo en una prueba de laboratorio clínico que deberá ser presentada.El caso debe ser informado al área de servicios estudiantiles.",
        "3e": "En el caso de los administrativos, estas medidas son obligatorias, y se han desplegado diferentes canales de comunicación para la toma de conciencia de los administrativos.El 100% de nuestros profesores y colaboradores se encuentran vacunados.",
        "4e": "Funcionarán cumpliendo medidas de bioseguridad específicas.",
        "5e": "Se tomarán las medidas técnicas de bioseguridad que las instalaciones requieran. En casos extremos, se evitará el uso de dichos ambientes.",

        "interaccion y apoyo estudiantil": "Realize una de las siguientes preguntas\n¿Qué es la Oficina de Apoyo Estudiantil?\n¿Qué estudiantes son candidatos a recibir los apoyos de la Oficina de Apoyo al Estudiante (OAE)?\n¿A partir de cuándo y hasta cuándo recibirán postulaciones para acceder a este fondo?\n¿Qué vigencia tienen los Apoyos de la OAE?\n¿Cuáles son los canales de comunicación para resolver mis dudas?\nQuiero agendar cita con un asesor de la OAE",
        "1f": "Es un área conformada por personal especializado que te ayudará en temas académicos y económicos, mayor información en la siguiente página: https://www.oae.unifranz.edu.bo/",
        "2f": "Todo estudiante regular de la universidad que demuestre la necesidad de apoyo y cuente con su certificado de vacunación contra el COVID-19 puede postular a alguno de los programas brindados por la Oficina de Apoyo Estudiantil (OAE).Para mayor información sobre planes de pago, la bolsa de apoyo económico, apoyo académico o asesoramiento en crédito educativo consulta la siguiente página: https://www.oae.unifranz.edu.bo/",
        "3f": "El calendario será actualizado en los próximos días, comunícate con el área de Servicios estudiantiles de tu sede para tener más información.",
        "4f": "Todos los programas de apoyo brindados por la OAE tienen vigencia dentro el semestre académico cuando se hace la postulación.",
        "5f": "Puedes escribirnos a los siguientes correos con tus datos personales y de contacto e inmediatamente nos contactaremos contigo:\nOAE La Paz: oae.lpz@unifranz.edu.bo\nOAE El Alto: oae_ea@unifranz.edu.bo\nOAE Cochabamba: oaecbba@unifranz.edu.bo\nOAE Santa Cruz: oae.scz@unifranz.edu.bo\nTambién puedes escribirnos vía WhatsApp al siguiente número 71502211 o a través de los chats habilitados en nuestras páginas oficiales en Facebook e Instagram en horarios de oficina.",
        "6f": "Por favor escribirnos a los siguientes correos con tus datos personales y de contacto\nOAE La Paz: oae.lpz@unifranz.edu.bo\nOAE El Alto: oae_ea@unifranz.edu.bo\nOAE Cochabamba: oaecbba@unifranz.edu.bo\nOAE Santa Cruz: oae.scz@unifranz.edu.bo\nPara mayor información consulta la siguiente página: https://www.oae.unifranz.edu.bo/",

    };

    // Verificar si alguna palabra clave está contenida en el userInput
    for (var keyword in keywordResponses) {
        if (userInput.toLowerCase().includes(keyword)) {
            return keywordResponses[keyword];
        }
    }

    return "Lo siento, no puedo responder a eso en este momento.";
}