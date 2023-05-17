from handlers.daba_base import get_connection

def get_orders() -> list:
    digital_tech = get_connection()
    orders: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT * FROM Orden_Productos")
        orders = cursor.fetchall()

    digital_tech.close()
    return orders

def get_user_orders(id: int) -> list:
    digital_tech = get_connection()
    orders: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT * FROM Orden_Productos WHERE ID_Usuario = '{id}'")
        orders = cursor.fetchall()

    digital_tech.close()
    return orders

def new_order(user_id: int) -> None:
    digital_tech = get_connection()
    products: tuple
    user_order: tuple
    
    with digital_tech.cursor() as cursor:
        cursor.execute(f"INSERT INTO Orden_Productos(ID_Usuario) VALUES ('{user_id}')")
        digital_tech.commit()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT ID_Producto, Cantidad FROM Productos_Carrito WHERE ID_Usuario = '{user_id}'")
        products = cursor.fetchall()

        cursor.execute(f"SELECT * FROM Orden_Productos WHERE ID = (SELECT MAX(ID) FROM Orden_Productos WHERE ID_Usuario = '{user_id}')")
        user_order = cursor.fetchone()

        for product in products:
            cursor.execute(f"INSERT INTO Productos_Orden(ID_Orden, ID_Producto, Cantidad) VALUES ('{user_order[0]}', '{product[0]}', '{product[1]}')")
            cursor.execute(f"UPDATE Producto SET Existencias = Existencias - '{product[1]}' WHERE ID = '{product[0]}'")
            digital_tech.commit()

        cursor.execute(f"DELETE FROM Productos_Carrito WHERE ID_Usuario = {user_id}")
        digital_tech.commit()

    digital_tech.close()

def get_products_from_order(id):
    digital_tech = get_connection()
    orders: tuple
    product: tuple
    products = []
    needed_info = []

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT ID_Producto, Cantidad, ID FROM Productos_Orden WHERE ID_Orden = '{id}'")
        orders = cursor.fetchall()

        for order in orders:
            cursor.execute(f"SELECT Nombre, Imagen, Precio, ID FROM Producto WHERE ID = '{order[0]}'")
            product = cursor.fetchone()

            needed_info.append(product[0])
            needed_info.append(product[1])
            needed_info.append(product[2])
            needed_info.append(order[1])
            needed_info.append(product[3])
            needed_info.append(order[2])

            products.append(needed_info)

            needed_info = []

    digital_tech.close()
    return products

    