---
title: "Piszemy paczkę NPM w es6"
description: "Jak opublikować paczę npm z wykorzystaniem es6, es7 oraz Babel CLI"
tags: ["js","npm"]
date: "2016-01-02"
categories:
    - "js"
---
Tym razem napiszemy i opublikujemy prostą paczkę es6 / es7.
Nie będziemy skupiać się na samym kodzie, lecz na krokach jakie musimy wykonać aby nasza paczka poprawnie działała.

# Transpilacja kodu do es5

Niestety javascript w wersji es6 i es7 nie jest jeszcze dobrze wspierany. Z tego powodu musimy użyć narzędzia Babel.
Jego zadaniem jest przekompilowanie kodu napisanego w es6, es7 do kodu w wersji es5,
który nie ma tylu ciekawych funkcji ale za to ma ogromne wspracie.
Warto pamiętać o tym, że nie wszystko można "przepisać" do wersji es5.
Do działania niektórych funkcji (np. Promise, Fetch) będziemy musieli użyć tzw. pollyfill - najprościej mówiąc kawałek kodu (łatka),
który udostępnia funkcjonalność, którą my programiści oczekujemy by była natywnie dostępna.
Po tym krótkim wprowadzeniu możemy zabierać się do pracy!

# Tworzymy paczkę i dodajemy zależności
Dla przykładu będę tworzył paczkę o nazwie `paczuszka`. Pamiętajcie, że nazwa powinna być unikatowa.

Stwórzmy najpierw katalog, w którym będziemy rozwijać naszą paczkę.
```
mkdir paczuszka
```

W folderze `paczuszka` uruchomimy komendę dzięki której stworzymy naszą paczkę.
```
npm init
```
<script type="text/javascript" src="https://asciinema.org/a/7apokxfs2ic8dgukks0lc29ks.js" id="asciicast-7apokxfs2ic8dgukks0lc29ks" async></script>

Jak już wcześniej wspomniałem będziemy potrzebować Babela. Aby dodać go do naszej paczki wydajmy polecenie:
```
npm install babel-cli babel-preset-es2015 -D
```
<script type="text/javascript" src="https://asciinema.org/a/ax6lwp6dv34h29k1q11npdps5.js" id="asciicast-ax6lwp6dv34h29k1q11npdps5" async></script>

Po zainstalowaniu niezbędnych paczek i dodaniu ich jako dev zależności (`-D` lub `--save-dev`) w naszej paczce
powinniśmy zobaczyć:
```
...
  "devDependencies": {
    "babel-cli": "^6.5.1",
    "babel-preset-es2015": "^6.5.0"
  }
...
```
Jeśli pisząc naszą paczkę chcemy również używać rzeczy z es7 to powinniśmy również doinstalować:
```
npm install babel-preset-stage-0 -D
```

# Struktura
Kolejnym krokiem jest stworzenie struktury dla naszej paczki. W naszym katalogu powinniśmy mieć:
```
/paczuszka/
|-- src
|   `-- main.js // kod es6, es7 do skompilowania
|-- dist // zostanie stworzony podczas kompilacji
|   `-- main.js // kod es5 skompilowany przez Babel
|-- package.json // nasza paczka
|-- .gitignore
`-- .npmignore
```

`src/main.js` - tutaj będziemy pisali nasz kod wykorzystując es6 czy es7. Dla przykładu wrzućmy:

```js
const unknown = 'some guy';

module.exports = (name = unknown) => {
    return `Hello, ${name}! Have a nice day`;
};
```

`dist/main.js` - tego pliku nie musimy tworzyć, zostanie on utworzony przez Babela podczas kompilacji
```js
'use strict';

var unknown = 'some guy';

module.exports = function () {
    var name = arguments.length <= 0 || arguments[0] === undefined ? unknown : arguments[0];

    return 'Hello, ' + name + '! Have a nice day';
};
```

`.gitignore` - przyda nam się aby zignorować folder `dist` oraz `node_modules` gdy będziemy naszą paczkę wrzucać na repozytorium. Nie ma potrzeby trzymania skomilowanego kodu ani też modułów node'a. Zawartość:
```
dist
node_modules
```

`.npmignore` - przyda nam się do zignorowania kodu źródłowego `src/main.js`. Na NPM powinniśmy trzymać tylko to co będziemy używać
czyli skompilowany do es5 kod - `dist/main.js`. Zawartość:
```
src
```

# NPM zadania
Utworzymy w npm 2 zadania, które ułatwią nam publikowanie i budowanie paczki:

```
...
"scripts": {
    // polecenie "test" możemy usunąć - nie będzie potrzebne
    "build": "babel --presets es2015,stage-0 -d dist/ src/",
    "prepublish": "npm run build"
}
...
```

Jak łatwo się domyślić `build` kompiluje nam nasz plik z folderu `src/` korzystając z predefiniowanych
es2015 oraz stage-0 do katalogu `dist/`. Zadaniem `prepublish` jest wykonanie kompilacji przed samym publikowaniem (przedrostek `pre`) do NPM'a.

# Budujemy i publikujemy
Jeśli jeszcze nie dodałeś swoich informacji o koncie NPM wykonaj:
```
npm login // lub npm adduser
```

Testujemy budowanie paczki
```
npm run build
```
<script type="text/javascript" src="https://asciinema.org/a/1gv379fpuffq04u7m8nxusccc.js" id="asciicast-1gv379fpuffq04u7m8nxusccc" async></script>

Testujemy publikowanie paczki
```
npm publish
```

<script type="text/javascript" src="https://asciinema.org/a/bmpt7ffoueqyc21gr2nivcd43.js" id="asciicast-bmpt7ffoueqyc21gr2nivcd43" async></script>

Zauważ, że usuneliśmy folder `dist`, który i tak później został stworzony dzięki `prepublish`, który
przed publikowaniem wykonuje `build`. (W międzyczasie zmieniłem wersję paczki na 1.0.10 żebym mógł kolejny raz ją wysłać)

Jeśli wszystko poszło OK powinniśmy mieć naszą paczkę w repozytorium NPM:
https://www.npmjs.com/package/paczuszka

Teraz przetestujmy czy działa:
<script type="text/javascript" src="https://asciinema.org/a/4rjfzjwhfv7jxfmtbeknjtvb3.js" id="asciicast-4rjfzjwhfv7jxfmtbeknjtvb3" async></script>

Na szybko stworzyłem nową paczkę npm i zainstalowałem wcześniej stworzoną "paczuszkę". Po krótkich testach w node
wygląda, że wszystko działa tak jak powinno!

Teraz wasza kolej!


