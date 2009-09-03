# Plugin para o Componente NUMERO_INTEIRO.
# Ele dará ao usuário a possibilidade de criar campos nos formulários que receberão
# números inteiros (sem a parte decimal), como código, matrícula, etc.
ActionView::Base.send :include, ValorMonetarioEcmHelper

