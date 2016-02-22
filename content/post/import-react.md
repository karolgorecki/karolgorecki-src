---
title: "Lepsze importowanie plików w ReactJS"
description: "Jak usprawnić importowanie w projektach opartych o Webpack i React"
tags: ["react", "js"]
date: "2015-12-20"
categories:
    - "js"
    - "react"
---
# Importowanie relatywne 😣
Jeśli miałeś przyjemność pracować z ReactJS to zapewne niejednokrotnie spotkałeś się z poniższym zapisem

```js
import Foo from '../../components/Foo';
import Bar from '../../containers/common/Bar.js';
```
Na pierwszy rzut oka wygląda OK, jednak na dłuższą metę taki zapis jest
nieco irytujący i może być w przyszłości problematyczny.
Co jeśli chcielibyśmy przenieść nasze komponenty lub kontenery w inne miejsce? No właśnie! Musielibyśmy
w kilkunastu lub kilkudziesięciu plikach zmieniać ścieżki.
Nie trudno też o pomyłki przy podawaniu lokalizacji gdy projekt nam się nieco rozrośnie.


# Webpack Resolve Alias 😍
Na szczęście istenieje sposób żeby usprawnić importowanie. Wystarczy, że skorzystamy z aliasów dostępnych
w Webpacku (`Webpack Alias`). Do naszej Webpackowej konfiguracji dodajemy:

```js
...
resolve: {
  alias: {
    '~': path.resolve(__dirname, 'src'),
    'components': path.resolve(__dirname, 'src/components'),
    'containers': path.resolve(__dirname, 'src/containers')
  }
},
...
```

Po tej prostej operacji możemy używać poniższych zapisów

```js
import Foo from '~/components/Foo';
import Bar from '~/containers/common/Bar.js';
// lub
import Foo from 'components/Foo';
import Bar from 'containers/common/Bar.js';
```

# Webpack modulesDirectories
Inną i nieco lepszą opcją jest użycie `modulesDirectories`. Do konfiguracji musimy dodać:
```
...
resolve: {
    modulesDirectories: [
      'src', // dodajemy katalog src
      'node_modules'
    ],
...
```

Do sekcji `modulesDirectories` dodajmy katalog `src`, w którym będziemy trzymać nasze komponenty,
kontenery itd. Kolejnym krokiem jest stworzenie pliku `index.js` dla komponentów oraz kontenerów.
Dla przykładu przyjrzyjmy się następującej strukturze
```js
nasz-projekt
 ├── ...
 └── src
     ├── components
     │   ├── Time
     │   │   └── Time.js
     │   ├── Counter
     │   │   └── Counter.js
     │   └── Button
     │   │   └── Button.js
     │   └── index.js // zawiera indeks komponentów
     │
     └── containers
         ├── Home
         │   └── Home.js
         ├── About
         │   └── About.js
         └── Contact
         │   └── Contact.js
         └── index.js // zawiera indeks kontenerów
```
Interesują nas tutaj pliki `index.js` w katalogu `src/components` oraz `src/containers`.
W naszych indeksach powinniśmy wyeksportować komponenty, które później chcemy importować:

```js
// src/components/index.js
export Time from './Time/Time';
export Counter from './Counter/Counter';
export Button from './Button/Button';
```
w powyższym kodzie eksportujemy wszystkie (3) nasze komponenty. Dzięki temu od teraz możemy importować tak:

```js
// src/containers/home
import {Time, Button} from 'components';
```
Trzeba przyznać, że takie importowanie jest o wiele czytelniejsze i przyjemniejsze 🙂
