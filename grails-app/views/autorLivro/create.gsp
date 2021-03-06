<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'autorLivro.label', default: 'AutorLivro')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <asset:javascript src="jquery-ui.js"/>
        <asset:stylesheet src="jquery-ui.css"/>
        <asset:stylesheet src="jquery-ui.theme.css"/>

    </head>
    <body>
        <a href="#create-autorLivro" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            </ul>
        </div>
        <div id="create-autorLivro" class="content scaffold-create" role="main">
            <h1>Adicionar Autor ao Livro</h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.autorLivro}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.autorLivro}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="save">
                <fieldset class="form">
                    <f:field bean="autorLivro" property="autor">
                        <g:select name="autor.id" from="${sab.livros.Autor.list(sort:'nome')}" optionKey="id"/>

                        <g:submitButton name="create" class="botao-normal" value="Adicionar este Autor"/>

                    </f:field>

                    <!-- Link para novo Autor-->
                    <g:link controller="Autor" action="create" target="_blank">Novo Autor</g:link>

                    <g:select name="livro.id" from="${sab.livros.Livro.get(params.long('livro.id'))}" optionKey="id" class="escondido"/>

                    <div class="fieldset">
                </fieldset>
            </g:form>

            <fieldset class="form">
                <div class="fieldcontain">
                    <table class="tabela-de-adicao">
                        <caption>Autores cadastrados</caption>
                        <g:each in="${autorLivroList}" var="autorLivro" status="i">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td>
                                    <g:link action="show" controller="Autor" id="${autorLivro.autor.id}"> ${autorLivro.autor.nome} </g:link>
                                </td>

                                <td>
                                    <g:form resource="${autorLivro}" method="DELETE">
                                        <fieldset class="buttons">
                                            <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                        </fieldset>
                                    </g:form>
                                </td>
                            </tr>
                        </g:each>
                    </table>
                </div>
            </fieldset>

            <fieldset class="buttons">
                <g:link action="show" controller="Livro" id="${params.long('livro.id')}">Voltar</g:link>
            </fieldset>
        </div>
    </body>
</html>
