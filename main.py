from flask import Flask, render_template, redirect, url_for, request, flash, session
import hashlib
from handlers.user import *
from handlers.employee import *

app = Flask(__name__)

# Ruta para la página principal
@app.route('/')
def index():
    username = session.get('username')
    return render_template('index.html', username = username)

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

    if user and user[3] == password:
        session['id'] = user[0]
        session['username'] = user[1]
        session['email'] = user[2]
        session['password'] = user[3]
        session['cellphone'] = user[4]
        session['address'] = user[5]
        return redirect('/')
    else:
        error = 'Correo electrónico o contraseña incorrectos'
        return render_template('login.html', error = error)
    
@app.route('/user_profile')
def user_profile():
    return render_template('user_profile.html')

@app.route('/logout')
def logout():
    session.pop('id', None)
    session.pop('username', None)
    session.pop('email', None)
    session.pop('phone', None)
    session.pop('password', None)
    session.pop('address', None)
    return redirect(url_for('index'))

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
    app.secret_key = '192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf'
    app.run()
    