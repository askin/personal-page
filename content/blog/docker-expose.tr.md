---
title: Docker EXPOSE
date: 2023-01-19T13:00:00+03:00
Author: Aşkın Özgür
Category: ["Linux"]
Tags: ["Devops", "Docker", "linux"]
Slug: docker-expose
draft: false
---

Bir etkinlik sırasında `EXPOSE` kullanımıyla ilgili bir anlaşmazlığa düştük, ben de biraz inceleyip onunla ilgili bir yazı yazmak istedim.
Öncelikle [Dockerfile referans](https://docs.docker.com/engine/reference/builder/#expose "Dockerfile reference") dökümanından `EXPOSE` ile ilgili verilen bilgiye bakalım.

> The `EXPOSE` instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.
> The `EXPOSE` instruction does not actually publish the port. It functions as a type of documentation between the person who builds the image and the person who runs the container, about which ports are intended to be published. To actually publish the port when running the container, use the `-p` flag on `docker run` to publish and map one or more ports, or the `-P` flag to publish all exposed ports and map them to high-order ports.

Dökümana göre `Dockerfile` içinde yazılan `EXPOSE` ifadesi herhangi bir port yönlendirme(publish) yapmıyor, çalıştırma sırasında uygulamanın hangi portların dışarı açabileceği konusunda `Docker`ı bilgilendiriyor.

Daha iyi anlamak için hemen bir örnek yapalım. Aşağıdaki `Dockerfile` ı kullanarak oluşturduğum bir imajım var. 

```Dockerfile
FROM python:3.9
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY ./app /code/app
CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8123"]
```

Görüldüğü üzere bu `Dockerfile` içinde herhangi bir port tanımlaması yapmadık. Sadece `uvicorn` uygulamasına `8123` portundan çalışacağını söyledik. 

Bunu aşağıdaki komutla çalıştırıp istek attığımızda beklediğimiz gibi çalıştığını görebiliyoruz.

```bash
docker run --rm --name test-without-expose -p 8123:8123 askinozgur/publish-port-without-expose
```

```bash
curl http://localhost:8123
```

```json
{"Hello":"World"}
```

Dökumanın söylediği, bizim de test edip gördüğümüz gibi port yönlendirebilmek için `EXPOSE` kullanmamız şart değil.

Peki `EXPOSE` bilgilendirme dışında başka hiç bir işe yaramıyor mu? Aslında `docker`ı çalıştırırken `-P` parametresini verirsek `EXPOSE` ile tanımlanmış bütün portları boşta bulunan bir porta yönlendirmiş olacağız.

Aşağıdaki `Dockerfile` kullanılarak oluşturulmuş imajı çalıştırdığımız bir örneğe bakalım.

```Dockerfile
FROM python:3.9
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY ./app /code/app

EXPOSE 8123

CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8123"]
```


```bash
docker run --rm --name test-with-expose -P askinozgur/publish-port-with-expose
```

```bash
docker ps
```

```
CONTAINER ID   IMAGE                                 COMMAND                  CREATED         STATUS         PORTS                                         NAMES
b3be17aef125   askinozgur/publish-port-with-expose   "uvicorn app.main:ap…"   5 seconds ago   Up 5 seconds   0.0.0.0:49157->8123/tcp, :::49157->8123/tcp   test-with-expose
```

`docker ps` çıktısınd görüldüğü gibi içerdeki `8123` portu dışarıya `49157` olarak yönlendirildi. Bu port her yeni konteyner oluşturulduğunda değişecektir.

Bu yazıda kullandığım örneklere aşağıdaki github reposundan erişebilirsiniz.

[https://github.com/askin/docker-examples](https://github.com/askin/docker-examples "Docker Örnekleri")
