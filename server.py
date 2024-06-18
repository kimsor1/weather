# -*- coding : utf-8 -*-

"""
author:
Description: MySQL의 python database와 CRUD
http://localhost:5000/?...
"""

from flask import Flask,jsonify,request
import json
import pymysql

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

@app.route("/insertuserinfo")
def insert():
    # Request for Get
    nickname = request.args.get("nickname")   

    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='clothes',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    # SQL 문장
    sql = 'insert into user(nickname) values (%s)'
    curs.execute(sql,nickname)
    conn.commit()
    conn.close()

    return jsonify([{'result':'OK'}])


@app.route("/selectuserinfo")
def select():
    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='clothes',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    # SQL 문장
    sql = 'select nickname from user where id = (select max(id) from user);'
    curs.execute(sql)
    rows=curs.fetchall()
    conn.close()

    result = json.dumps(rows,ensure_ascii=False).encode('utf8')

    return result

@app.route("/insertouter")
def insert_outer():
    # Request for Get
    nickname = request.args.get("nickname")
    padding = int(request.args.get("padding"))
    wintercoat = int(request.args.get("wintercoat"))
    lightpadding = int(request.args.get("lightpadding"))
    trenchcoat = int(request.args.get("trenchcoat"))
    thincoat = int(request.args.get("thincoat"))
    cardigan = int(request.args.get("cardigan"))
    zipup = int(request.args.get("zipup"))
    thincardigan = int(request.args.get("thincardigan"))

    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='clothes',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    # SQL 문장
    sql = '''INSERT INTO chooseouter (nickname,padding, wintercoat, lightpadding, trenchcoat, thincoat, cardigan, zipup, thincardigan)
             VALUES (%s,%s, %s, %s, %s, %s, %s, %s, %s)'''
    curs.execute(sql, (nickname,padding, wintercoat, lightpadding, trenchcoat, thincoat, cardigan, zipup, thincardigan))
    conn.commit()
    conn.close()

    return jsonify([{'result': 'OK'}])

@app.route("/inserttop")
def insert_top():
    # Request for Get
    nickname = request.args.get("nickname")   
    sleeveless = int(request.args.get("sleeveless"))
    shortsleeve = int(request.args.get("shortsleeve"))
    thinlongsleeve = int(request.args.get("thinlongsleeve"))
    longsleeveshirt = int(request.args.get("longsleeveshirt"))
    hoodie = int(request.args.get("hoodie"))
    sweatshirt = int(request.args.get("sweatshirt"))
    knit = int(request.args.get("knit"))

    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='clothes',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    # SQL 문장
    sql = '''INSERT INTO choosetop (nickname,sleeveless, shortsleeve, thinlongsleeve, longsleeveshirt, hoodie, sweatshirt, knit)
             VALUES (%s,%s, %s, %s, %s, %s, %s, %s)'''
    curs.execute(sql, (nickname,sleeveless, shortsleeve, thinlongsleeve, longsleeveshirt, hoodie, sweatshirt, knit))
    conn.commit()
    conn.close()

    return jsonify([{'result': 'OK'}])

@app.route("/insertbottom")
def insert_bottom():
    # Request for Get
    nickname = request.args.get("nickname")   
    shorts = int(request.args.get("shorts"))
    jeans = int(request.args.get("jeans"))
    fleecepants = int(request.args.get("fleecepants"))

    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='clothes',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    # SQL 문장
    sql = '''INSERT INTO choosebottom (nickname,shorts, jeans, fleecepants)
             VALUES (%s, %s, %s, %s)'''
    curs.execute(sql, (nickname,shorts, jeans, fleecepants))
    conn.commit()
    conn.close()

    return jsonify([{'result': 'OK'}])

if __name__ == '__main__':
    app.run(host='127.0.0.1',port=5000, debug=True)