## Brute Force

### Как запускать ?
```
stack run +RTS -s -N*
```
где флаг -s нужен для вывода статистики о времени исполнения;
флаги +RTS -N* для запуска на нескольких ядрах, на месте * ставим количество ядер;
-N запускает на всех доступных ядрах

### Пример работы программы
8 ядер
```
>stack run +RTS -s -N
enter hash here:
4c55e5e5fc2235cc8c201e69a345f7fab3fb46fa
***SUCCES***
BBBB
```

* Total   time    1.266s  (  6.759s elapsed)

4 ядра
```
>stack run +RTS -s -N4
enter hash here:
4c55e5e5fc2235cc8c201e69a345f7fab3fb46fa
***SUCCES***
BBBB
```

*  Total   time    0.500s  ( 17.633s elapsed)
