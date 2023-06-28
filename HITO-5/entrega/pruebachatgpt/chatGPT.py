import openai
# Indica el API Key
openai.api_key = "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"
# Uso de ChapGPT en Python
model_engine = "text-davinci-003"
prompt = "que es tnsor flow"
completion = openai.Completion.create(engine=model_engine,
                                    prompt=prompt,
                                    max_tokens=1024,
                                    n=1,
                                    stop=None,
                                    temperature=0.7)
respuesta=""
for choice in completion.choices:
    respuesta=respuesta+choice.text
    print(f"Response: %s" % choice.text)