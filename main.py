from flask import Flask, render_template, redirect, url_for, request, flash
import hashlib
from handlers.user import *
from handlers.employee import *

app = Flask(__name__)

# Ruta para la página principal
@app.route('/')
def index():
    return render_template('index.html')

# Ruta para la página de registro
@app.route('/register')
def register():
    return render_template('register.html')

@app.route('/register', methods = ['POST'])
def register_post():
    name = request.form['name']
    email = request.form['email']
    cellphone = request.form['cellphone']
    address = request.form['address']
    password = request.form['password']

    password = hashlib.md5(password.encode()).hexdigest()

    if not new_user(name, email, cellphone, address, password):
        flash('Ha ocurrido un error')
        return redirect('/register')

    return redirect('/login')


# Ruta para la página de logeo
@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_post():
    email = request.form['email']
    password = request.form['password']

    password = hashlib.md5(password.encode()).hexdigest()

    user = get_user(email)

    if user and user[2] == password:
        return redirect('/')
    else:
        error = 'Correo electrónico o contraseña incorrectos'
        return render_template('login.html', error = error)

# Ruta para la página de logeo de empleados
@app.route('/employee_login')
def employee_login():
    return render_template('employee_login.html')

@app.route('/employee_login', methods=['POST'])
def employee_login_post():
    id = request.form['employee_id']
    password = request.form['password']

    password = hashlib.md5(password.encode()).hexdigest()

    employee = get_employee(id)

    if employee and employee[2] == password:
        return redirect('/')
    else:
        error = 'Código de empleado o contraseña incorrectos'
        return render_template('employee_login.html', error = error)

if __name__ == '__main__':
    app.run()
