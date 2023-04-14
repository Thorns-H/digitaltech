from handlers.daba_base import get_connection

# Relacionado a la Entidad Producto

def new_product(name: str, description: str, brand: str, category: str) -> None:
    digital_tech = get_connection()
    
    with digital_tech.cursor() as cursor:
        cursor.execute("INSERT INTO Producto(Nombre, Descripcion, Marca, Categoria) VALUES (%s, %s, %s, %s, %s)", (name, description, brand, category))
    
    digital_tech.commit()
    digital_tech.close()

def get_products() -> list:
    digital_tech = get_connection()
    products: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT * FROM Producto WHERE Estatus = 'Activo'")
        products = cursor.fetchall()

    digital_tech.close()
    return products