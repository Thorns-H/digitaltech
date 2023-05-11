from handlers.daba_base import get_connection

def get_comments(id_product: str) -> tuple:
    digital_tech = get_connection()
    comments: tuple

    with digital_tech.cursor() as cursor:
        cursor.execute(f"SELECT Usuario.ID, Usuario.Nombre, Comentarios.Comentario, Comentarios.ID FROM Comentarios JOIN Usuario ON Comentarios.ID_Usuario = Usuario.ID JOIN Producto ON Comentarios.ID_Producto = Producto.ID WHERE Comentarios.ID_Producto = {id_product};")
        comments = cursor.fetchall()

    digital_tech.close()
    return comments

def create_comment(id_product: str, id_user: str, comment: str) -> None:
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"INSERT INTO Comentarios(ID_Producto, ID_Usuario, Comentario) VALUES ('{id_product}', '{id_user}', '{comment}')")

    digital_tech.commit()
    digital_tech.close()

def remove_comment(id: str):
    digital_tech = get_connection()

    with digital_tech.cursor() as cursor:
        cursor.execute(f"DELETE FROM Comentarios WHERE ID = '{id}'")

    digital_tech.commit()
    digital_tech.close()