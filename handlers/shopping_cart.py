from handlers.daba_base import get_connection

def get_shopping_cart(user_id: int) -> tuple:
    digital_tech = get_connection()
    cart: tuple
    product: tuple
    needed_info: list = []
    shopping: list = []

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT ID_Producto, Cantidad FROM Productos_Carrito WHERE ID_Usuario = '{user_id}'")
        cart = cursor.fetchall()
        for id in cart:
            cursor.execute(f"SELECT * FROM Producto WHERE ID = '{id[0]}'")
            product = cursor.fetchone()

            needed_info.append(product[1])
            needed_info.append(product[6])
            needed_info.append(round(product[7] * id[1], 2))
            needed_info.append(id[1])
            needed_info.append(id[0])

            shopping.append(needed_info)

            needed_info = []

    digital_tech.close()

    return shopping

def add_to_cart(user_id: int, product_id: int, quantity: int):
    digital_tech = get_connection()
    table: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT ID, Cantidad FROM Productos_Carrito WHERE ID_Producto = {product_id}")
        table = cursor.fetchone()
        if table:
            cursor.execute(f"UPDATE Productos_Carrito SET Cantidad = '{int(table[1]) + int(quantity)}'")
        else:
            cursor.execute(f"INSERT INTO Productos_Carrito (ID_Usuario, ID_Producto, Cantidad) VALUES ('{user_id}', '{product_id}', '{quantity}')")

    digital_tech.commit()
    digital_tech.close()

def remove_from_cart(user_id: int, product_id: int):
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"DELETE FROM Productos_Carrito WHERE ID_Producto = {product_id} AND ID_Usuario = {user_id}")

    digital_tech.commit()
    digital_tech.close()

def clear_cart(user_id: int):
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"DELETE FROM Productos_Carrito WHERE ID_Usuario = {user_id}")

    digital_tech.commit()
    digital_tech.close()