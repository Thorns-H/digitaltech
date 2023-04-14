import pymysql

def get_connection() -> pymysql.connections.Connection:
    return pymysql.connect(host='localhost', user='root', password='123', db='digital_tech')