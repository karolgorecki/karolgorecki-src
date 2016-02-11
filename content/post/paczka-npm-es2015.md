---
title: "Piszemy paczkę NPM w es6"
description: "Jak opublikować paczę npm z wykorzystaniem es6, es7 oraz Babel CLI"
draft: true
tags: ["js","npm"]
date: "2016-01-02"
categories:
    - "js"
---
Tym razem napiszemy i opublikujemy prostą paczkę w es6 / es7.

Co będzie nam potrzebne?

- konto na npm
- ...
- ...

Niestety javascript w wersji es6 i es7 nie jest jeszcze dobrze wspierany. Z tego powodu musimy użyć narzędzia Babel.
Jego zadaniem jest przekompilowanie kodu napisanego w es6, es7 do kodu w wersji es5,
który nie ma tylu ciekawych funkcji ale za to ma ogromne wspracie.
Warto pamiętać o tym, że nie wszystko można "przepisać" do wersji es5.
Do działania niektórych funkcji (np. Promise, Fetch) będziemy musieli użyć tzw. pollyfill - najprościej mówiąc kawałek kodu (łatka),
który udostępnia funkcjonalność, którą my programiści oczekujemy by była natywnie dostępna.
