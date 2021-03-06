package sab.livros

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AutorLivroController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AutorLivro.list(params), model:[autorLivroCount: AutorLivro.count()]
    }

    def show(AutorLivro autorLivro) {
        respond autorLivro
    }

    def create() {

        def autorLivroList = AutorLivro.withCriteria {
            livro{
                eq 'id', params.long('livro.id')
            }
        }

        respond new AutorLivro(params), model:[autorLivroList: autorLivroList]
    }

    @Transactional
    def save(AutorLivro autorLivro) {
        if (autorLivro == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (autorLivro.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond autorLivro.errors, view:'create'
            return
        }

        autorLivro.save flush:true

        redirect (action:"create", params:['livro.id':autorLivro.livro.id])
    }

    def edit(AutorLivro autorLivro) {
        respond autorLivro
    }

    @Transactional
    def update(AutorLivro autorLivro) {
        if (autorLivro == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (autorLivro.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond autorLivro.errors, view:'edit'
            return
        }

        autorLivro.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'autorLivro.label', default: 'AutorLivro'), autorLivro.id])
                redirect autorLivro
            }
            '*'{ respond autorLivro, [status: OK] }
        }
    }

    @Transactional
    def delete(AutorLivro autorLivro) {

        if (autorLivro == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        autorLivro.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'autorLivro.label', default: 'AutorLivro'), autorLivro.id])
                redirect (controller:"AutorLivro", action:"create", params:['livro.id': autorLivro.livro.id])
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'autorLivro.label', default: 'AutorLivro'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
