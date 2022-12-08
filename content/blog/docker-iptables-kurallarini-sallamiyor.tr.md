---
title: Docker Iptables Kurallarını Sallamıyor
date: 2022-12-08T18:30:00+03:00
Author: Aşkın Özgür
Category: ["Linux"]
Tags: ["Devops", "Docker", "linux"]
Slug: docker-iptables-kurallarini-sallamiyor
draft: false
---

Farketmem nedense biraz zaman aldı, bir docker container'ının portunu publish ettiğimizde arka tarafta bizden habersiz o port erişime açılıyor. UFW, FirewallD ya da doğrudan iptables kullanmanız farketmiyor.

Bazı servislere gelen anlamsız istekleri incelerken farkettim bunu. Çözmem de biraz sancılı oldu, yanlış bir firewall ayarı nedeniyle böyle birşey olduğunu düşündüğüm için çözüm bulmam zorlaştı. Siz de böyle bir durumdaysanız aşağıdaki yöntemlerden birini kullanabilirsiniz.


`/etc/docker/daemon.json` dosyasına aşağıdaki satırları ekledikten sonra docker daemonu yeniden başlatabilirsiniz.

```json
{
  "iptables" : false
}
```

Ya da

Docker servisini başlatırken `--iptables=false` parametresiyle başlatabilirsiniz.

Bu yazıda aynı problemi yaşayan başka birisi var. Eğlenceli bir yazı olmuş ona da bakabilirsiniz. [Why Docker and Firewall don’t get along with each other!](https://erfansahaf.medium.com/why-docker-and-firewall-dont-get-along-with-each-other-ddca7a002e10 "Why Docker and Firewall don’t get along with each other!")

<!--more-->
