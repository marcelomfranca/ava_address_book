# Livro de endereços

<br />

Livro de endereços proposto pelo desafio AVA a seguir.

---


<br />

Crie um aplicativo seguindo a descrição abaixo: 

- A primeira tela do app deve ser a de Login, caso o usuário já possua conta, basta informar e-mail e senha e logar na aplicação. Caso o  usuário não possua conta ele irá clicar na opção de Signup. 

- A tela de signup deve conter os seguintes campos: Nome, E-Mail, Senha e Confirme a sua Senha. Uma vez o usuário cadastrado na aplicação, NÃO é necessário validação de conta através de e-mail, sms ou qualquer outra forma. 

- Estando logado, na próxima tela o usuário pode cadastrar um ou mais endereços para ele com os seguintes campos: CEP, Rua,  Complemento, Bairro, Localidade, Estado (ex: SP). Ao informar o cep que deverá ser o primeiro campo do formulário é necessário usar a api  da viacep (https://viacep.com.br/) para preencher automaticamente os demais campos, que posteriormente podem ser alterados  manualmente pelo usuário. 

- Cada usuário ao logar deve ver somente os endereços que ele cadastrou e deverá poder editar individualmente cada um deles. É necessário haver uma opção de troca de senha e também de logout. 

Requisitos: 

- O app deve ser feito em Flutter. 

- Utilizar a base de dados SQLite. 

- O app deverá ser buildado para .apk para Android. 

Material de apoio: 

- Lib do SQLite para Flutter: https://pub.dev/packages/sqflite 

- Templates gratuitos do Figma que podem ser usados no app: https://www.figma.com/templates/ 
