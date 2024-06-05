import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions, this.onRemove);

  final List<Transaction> transactions;
  final void Function(String id) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560,
      child: transactions.isEmpty
          ? Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Text('Nenhuma Transação cadastrada'),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ])
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(
                          'R\$' + tr.value.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      tr.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(DateFormat('dd/MM/yyyy').format(tr.date)),
                    trailing: IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.delete),
                      onPressed: () => onRemove(tr.id),
                    ),
                  ),
                );
              }),
    );
  }
}
