package br.com.jcbank

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class JcBankApplication

fun main(args: Array<String>) {
	runApplication<JcBankApplication>(*args)
}
