from todor import create_app

def test_app_creation():
    """Prueba que la aplicación se crea correctamente"""
    app = create_app()
    assert app is not None
    assert app.config["TESTING"] is False  

def test_home_page():
    """Prueba básica de que la ruta principal funciona"""
    app = create_app()
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200