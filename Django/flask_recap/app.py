from flask import Flask
from flask import render_template
import random
from flask import request
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/mulcam')
def mulcam():
    return "We are at Mulcam"

@app.route('/greeting/<string:name>')
def greeting(name):
    return f'반갑습니다. {name}님!'

@app.route('/cube/<int:num>')
def cube(num):
    return str(num*num*num)

@app.route('/dinner/<int:person>')
def dinner(person):
    menu = ["뼈해장국", "햄버거"]
    order = random.sample(menu, person)
    return str(order)

@app.route('/html')
def html():
    markup = '''
    <h1>This is h1 tag.</h1>
    <p>This is p tag.</p>
    '''
    return markup

# html 문서와 연결
@app.route('/html_file')
def html_file():
    return render_template('html_file.html')

# html 문서와 연결 + 변수 받기 
@app.route('/hi/<string:name>')
def hi(name):
    return render_template('hi.html', your_name=name)

# form 액션
@app.route('/naver')
def naver():
    return render_template('naver.html')

# 사용자 요청 처리 
@app.route('/send')
def send():
    return render_template('send.html')

@app.route('/receive')
def receive():
    name = request.args.get("name")
    message = request.args.get("message")    
    return render_template('receive.html', name=name, message=message)

@app.route('/vonvon')
def vonvon():
    return render_template('vonvon.html')

@app.route('/result')
def result():
    name = request.args.get("name")
    features = ['돈복', '순수함', '사랑스러움', '일복', '명예']
    chosen = random.sample(features, 3)

    return render_template('result.html', name=name, chosen=chosen)

if __name__=="__main__":
    app.run(debug=True)

