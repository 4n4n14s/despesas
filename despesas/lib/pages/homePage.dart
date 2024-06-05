import 'dart:math';

import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transacitions_form.dart';
import 'package:despesas/components/transactions_list.dart';
import 'package:despesas/model/transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas pessoais',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            color: Colors.white,
            style: IconButton.styleFrom(
              iconSize: 30,
            ),
            onPressed: () => _mostrarModal(context),
            icon: Icon(Icons.add_circle_outline),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            TransactionList(transactions, _deleteTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarModal(context),
        child: Icon(
          Icons.add_circle_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _deleteTransactions(String id) {
    setState(() {
      transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  // Função para exibir o modal
  void _mostrarModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }
}
