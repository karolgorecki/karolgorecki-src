---
title: "Lepsze importowanie plików w ReactJS"
description: "Jak usprawnić importowanie w projektach opartych o Webpack i React"
draft: true
tags: ["react", "js"]
date: "2015-12-10"
categories:
    - "js"
    - "react"
---

Importowanie 2.0 w projektach ReactJS
=====================================

**Przed**

```js
import Foo from '../../components/Foo';
import Bar from '../../containers/common/Bar.js';
```

**Po**

```js
import Foo from '~/components/Foo';
import Bar from '~/containers/common/Bar.js';
```

**Lub nawet**

```js
import Foo from 'components/Foo';
import Bar from 'containers/common/Bar.js';
```

Do rozwiązania tego nieco irytującego problemu przyda nam się *Webpack Alias*.  
Wystarczy, że w konfiguracji zamieścimy:

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