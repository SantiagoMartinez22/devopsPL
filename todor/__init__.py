from flask import Flask
def create_app():

    app = Flask(__name__)

    #configuracion del proyecto
    app.config.from_mapping(
        DEBUG =True,
        SECRET_KEY = 'dev'
    )

    @app.route('/')
    def index():
        return 'hola mundo'


    return app