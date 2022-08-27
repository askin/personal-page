---
Title: İngilizce Klavye Düzeninde Türkçe Karakter Kullanmak
Date: 2022-08-23T22:00:00+03:00
Author: Aşkın Özgür
Category: Linux
Tags: ["linux"]
Slug: ingilizce-klavye-duzeninde-turkce-karakter-kullanmak
Status: published
---

Yazılım geliştirirken ingilizce klavye kullanmak çok pratik oluyor. Geliştirme sırasında bolca kullandığım ```[] ` {} ~ \ |``` gibi karakterler ingilizce klavyede erişimin çok kolay olduğu bölgelerde, bunun yanında türkçe karakterlere hemen hemen hiç ihtiyacım olmuyor. Bu nedenle bir süredir ingilizce klavye kullanmaya başladım. Bunun yanında günlük iletişimin çoğunluğu türkçe. İş arkadaşlarım ve yakın çevremle konuşurken türkçe karakter kullanmamak pek sorun olmuyor, fakat bir müşteriye mail atarken, ya da şuan olduğu gibi blog yazarken türkçe karakter kullanmak şart oluyor. 

<!--more-->

İlk zamanlar klavye kısa yoluyla sürekli ingilizce - türkçe düzeni arasında geçiş yapıyordum. Fakat bir süre sonra bu şekilde kullanım verimsiz olmaya başladı. Ben de ingilizce klavye düzenine nasıl türkçe karakterleri ekleyebileceğimi araştırmaya başladım. 

Aşağıdaki adımları takip ederek türkçe karakterleri ingilizce klavye düzenine ekleyebilirsiniz. Sonrasında türkçe karakterlere erişmek için `Alt Gr` yani sağ taraftaki `Alt` tuşunu kullanabilirsiniz. Ben hem türkçe klavyedeki orijinal yerlerine hem de `s g i` gibi karakterin yerine türkçelerini ekledim.

| Karakter | Kombinasyon 1        | Kombinasyon 2        |              |
|:--------:|----------------------|----------------------|--------------|
| ç        | `Alt Gr` `c`         | `Alt Gr` `.`         |              |
| ç        | `Alt Gr` `Shift` `c` | `Alt Gr` `Shift` `.` |              |
| ğ        | `Alt Gr` `g`         | `Alt Gr` `[`         |              |
| Ğ        | `Alt Gr` `Shift` `g` | `Alt Gr` `Shift` `[` |              |
| ı        | `Alt Gr` `i`         |                      |              |
| İ        | `Alt Gr` `Shift` `i` | `Alt Gr` `Shift` `'` | `Alt Gr` `'` |
| ö        | `Alt Gr` `o`         | `Alt Gr` `,`         |              |
| Ö        | `Alt Gr` `Shift` `o` | `Alt Gr` `Shift` `,` |              |
| ş        | `Alt Gr` `s`         | `Alt Gr` `;`         |              |
| Ş        | `Alt Gr` `Shift` `s` | `Alt Gr` `Shift` `;` |              |
| ü        | `Alt Gr` `u`         | `Alt Gr` `]`         |              |
| Ü        | `Alt Gr` `Shift` `u` | `Alt Gr` `Shift` `]` |              |


`/usr/share/X11/xkb/symbols/us` dosyasına aşağıdaki gibi bir ayar ekliyoruz.

```
partial alphanumeric_keys
xkb_symbols "askin" {

    include "us(basic)"
    name[Group1]= "English (TR - askin)";
    key <AD11> { [ bracketleft,  braceleft,      gbreve,           Gbreve ] };
    key <AC05> { [           g,          G,      gbreve,           Gbreve ] };

    key <AD12> { [bracketright, braceright,  udiaeresis,       Udiaeresis ] };
    key <AD07> { [           u,          U,  udiaeresis,       Udiaeresis ] };

    key <AC10> { [   semicolon,      colon,    scedilla,         Scedilla ] };
    key <AC02> { [           s,          S,    scedilla,         Scedilla ] };

    key <AD08> { [           i,          I,    idotless,        Iabovedot ] };
    key <AC11> { [  apostrophe,    quotedbl,  Iabovedot,        Iabovedot ] };

    key <AB08> { [       comma,       less,  odiaeresis,       Odiaeresis ] };
    key <AD09> { [           o,          O,  odiaeresis,       Odiaeresis ] };

    key <AB09> { [      period,    greater,    ccedilla,         Ccedilla ] };
    key <AB03> { [           c,          C,    ccedilla,         Ccedilla ] };

    include "level3(ralt_switch)"
};
```

Burdaki `key <AD11>` klavyedeki yeri temsil ediyor. `Gbreve` ise `Ğ` karakterine denk geliyor. Ben `us` ve `tr` klavye düzenlerine bakarak bunların yerlerini ve anlamlarını çözemeye çalıştım. Klavye yerlerini tek tek yazmam pek mümkün değil fakat türkçe karakterlerin karşılıklarını aşağıya ekliyorum. Bu sayede kendi kullanım alışkanlığınıza ğöre düzenleme yapabilirsiniz.

| Karakter İsmi | Karakter | Karakter İsmi | Karakter |
|---------------|:--------:|---------------|:--------:|
| `gbreve`      | `ğ`      | `Gbreve`      | `Ğ`      |
| `udiaeresis`  | `ü`      | `Udiaeresis`  | `Ü`      |
| `scedilla`    | `ş`      | `Scedilla`    | `Ş`      |
| `idotless`    | `ı`      | `Iabovedot`   | `İ`      |
| `odiaeresis`  | `ö`      | `Odiaeresis`  | `Ö`      |
| `ccedilla`    | `ç`      | `Ccedilla`    | `Ç`      |


`/usr/share/X11/xkb/rules/evdev.xml` dosyasında `English (US)`'un olduğu `layout`'un altına aşağıdaki gibi yeni bir `variant` ekleyin.

```xml
<variant>
    <configItem>
        <name>askin</name>
        <description>English (askin)</description>
    </configItem>
</variant>
```

Bu ayarları yaptıktan sonra oturum kapatıp açtığınızda sitemde `Englis (askin)` adında yeni bir klavye düzeni olacaktır. Tabi istemini istediğiniz birsey yapabilirsiniz :)

Bu dosyaların son hallerine aşağıdaki linklerden ulaşabilirsiniz.

Github: [https://gist.github.com/askin/635bf8b14959b00409b8db37c33882fa](https://gist.github.com/askin/635bf8b14959b00409b8db37c33882fa)

[us](/keyboard-layout/us)

[evdev.xml](/keyboard-layout/evdev.xml)

Sistemde birden fazla `us` klavye düzeni olduğunda ` IntelliJ IDEA`'nın kısa yolları bende bozuldu. Sizde de benzer bir problem olursa bu yeni klavye düzenini sistemde ilk sıraya getirin, ya da sadece bu olacak şekilde çalışmayı deneyin.
