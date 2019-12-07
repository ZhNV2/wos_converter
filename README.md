# wos_converter

## Инструкция:

1. Скачать с WoS куски в формате .ciw (скорее всего вам понадобится "полная запись и пристатейные ссылки") для этого надо выбрать "Настольная версия EndNote"
2. с помощью скрипта слить куски в один .csv файл
3. загрузить .csv в open refine, там фильтровать данные, туториал здесь -> (https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=2ahUKEwih97-Yu6PmAhWmxcQBHXMaDzgQFjAAegQIAhAC&url=https%3A%2F%2Fged.univ-lille.fr%2Fnuxeo%2Fnxfile%2Fdefault%2F9b2701b4-7b8f-4754-8693-7072ee219706%2Fblobholder%3A0%2Ftutorial_openrefine_vosviewer_feret.pdf&usg=AOvVaw3Y0CEig-XOC2fepm96pFsR)
4. скачать из open refine документ в формате .csv 
5. дальше следовать инструкции из скрипта (там все очень просто)

## Замечание:
Для 2000 записей данные пропущенные через open refine и convert.r и просто скачанные с wos показали одинаковые результаты на методе biblioAnalysis, за исключением поля Sources (Journals, Books, etc.), которое получается немного неточным из-за технических сложностей реализации конвертера. Все остальные поля полностью совпадают