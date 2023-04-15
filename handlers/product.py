from handlers.daba_base import get_connection

# Relacionado a la Entidad Producto

def new_product(name: str, brand: str, category: str, status: str, description: str, image: str, price: str) -> None:
    digital_tech = get_connection()
    
    with digital_tech.cursor() as cursor:
        cursor.execute("INSERT INTO Producto(Nombre, Marca, Categoria, Estatus, Descripcion, Imagen, Precio) VALUES (%s, %s, %s, %s, %s, %s, %s)", (name, brand, category, status, description, image, price))
    
    digital_tech.commit()
    digital_tech.close()

def get_product(id: int) -> tuple:
    digital_tech = get_connection()
    product: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT * FROM Producto WHERE ID = '{id}'")
        product = cursor.fetchone()

    digital_tech.close()
    return product

def get_products() -> list:
    digital_tech = get_connection()
    products: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT * FROM Producto")
        products = cursor.fetchall()

    digital_tech.close()
    return products

def update_product(id: str, name: str, brand: str, category: str, status: str, description: str, image: str, price: str):
    digital_tech = get_connection()
    
    with digital_tech.cursor() as cursor:
        cursor.execute(f"UPDATE Producto SET Nombre = '{name}', Marca = '{brand}', Categoria = '{category}', Estatus = '{status}', Descripcion = '{description}', Imagen = '{image}', Precio = '{price}' WHERE ID = '{id}'")

    digital_tech.commit()
    digital_tech.close()

def remove_product(id: str):
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT Estatus FROM Producto WHERE ID = '{id}'")
        status = cursor.fetchone()

        if status[0] == 'Activo':
            cursor.execute(f"UPDATE Producto SET Estatus = 'Inactivo' WHERE ID = '{id}'")
        else:
            cursor.execute(f"UPDATE Producto SET Estatus = 'Activo' WHERE ID = '{id}'")

    digital_tech.commit()
    digital_tech.close()