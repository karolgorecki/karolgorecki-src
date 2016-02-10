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
