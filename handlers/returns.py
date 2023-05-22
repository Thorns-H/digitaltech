from handlers.daba_base import get_connection

def create_return(id_user: int, reason: str, products_to_update: list, id_order: int):
    digital_tech = get_connection()
    user_return: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"INSERT INTO Devolucion(ID_Usuario, Motivo, Estatus) VALUES ('{id_user}', '{reason}', 'Pendiente')")
        digital_tech.commit()

        cursor.execute(f"SELECT ID FROM Devolucion WHERE ID = (SELECT MAX(ID) FROM Devolucion WHERE ID_Usuario = '{id_user}')")
        user_return = cursor.fetchone()

        for product in products_to_update:
            cursor.execute(f"INSERT INTO Productos_Devolucion(ID_Devolucion, Cantidad, ID_Producto) VALUES ('{user_return[0]}', '{product[1]}', '{product[0]}')")
            digital_tech.commit()
            cursor.execute(f"UPDATE Productos_Orden SET Cantidad = Cantidad - '{product[1]}' WHERE ID_Orden = '{id_order}' AND ID_Producto = '{product[0]}'")
            digital_tech.commit()
            cursor.execute("DELETE FROM Productos_Devolucion WHERE Cantidad = 0")
            digital_tech.commit()

    digital_tech.close()

def get_returns() -> list:
    digital_tech = get_connection()
    returns: list

    with digital_tech.cursor() as cursor:
        cursor.execute("SELECT pd.*, p.Nombre, p.Imagen, d.Estatus, d.Motivo FROM Productos_Devolucion pd JOIN Producto p ON pd.ID_Producto = p.ID JOIN Devolucion d ON pd.ID_Devolucion = d.ID;")
        returns = cursor.fetchall()

    digital_tech.close()
    return returns

def accept_return(product_id: int, quantity: int, return_id: int) -> None:
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"UPDATE Producto SET Existencias = Existencias + '{quantity}' WHERE ID = '{product_id}'")
        digital_tech.commit()
        cursor.execute("DELETE FROM Productos_Orden WHERE Cantidad = 0")
        digital_tech.commit()
        cursor.execute(f"UPDATE Devolucion SET Estatus = 'Finalizado' WHERE ID = {return_id}")
        digital_tech.commit()

    digital_tech.close()