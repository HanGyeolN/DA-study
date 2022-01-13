import requests as rq 
import lxml

# response = rq.get("http://127.0.0.1:8000/articles/")

# print(response.text)

client = rq.session()

url = "http://127.0.0.1:8000/articles/create/"
client.get(url)
csrftoken = client.cookies['csrftoken']
print(csrftoken)

data = {
    'title':'test_title',
    'content':'test_ctn',
    'csrfmiddlewaretoken':csrftoken,
}
res = client.post("http://127.0.0.1:8000/articles/create/", data)

print(res.text)