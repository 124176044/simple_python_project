import 'package:flutter/material.dart';
import 'package:sample_application/models_bp.dart';
import 'package:sample_application/model_bp2.dart';

const availablemodels = [
  Model_bp(
    id: 'c1',
    title: 'LSTM',
    color: Colors.purple,
  ),
  Model_bp(
    id: 'c2',
    title: 'BILSTM',
    color: Colors.red,
  ),
  Model_bp(
    id: 'c3',
    title: 'GRU',
    color: Colors.orange,
  ),
];

final dummyModels = [
  const Model(
      id: 'm1',
      categories: [
        'c1',
      ],
      title: 'LONG SHORT TERM MEMORY',
      imageUrl:
          'https://miro.medium.com/v2/resize:fit:828/format:webp/1*Mb_L_slY9rjMr8-IADHvwg.png',
      description: 'Boil some water - add salt to it once it boils.'
          'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.'
          'In the meantime, heaten up some olive oil and add the cut onion.'
          'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.'
          'The sauce will be done once the spaghetti are.'
          'Feel free to add some cheese on top of the finished dish'),
  const Model(
      id: 'm2',
      categories: [
        'c2',
      ],
      title: 'BIDIRECTIONAL LONG SHORT TERM MEMORY',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
      description: 'Boil some water - add salt to it once it boils.'
          'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.'
          'In the meantime, heaten up some olive oil and add the cut onion.'
          'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.'
          'The sauce will be done once the spaghetti are.'
          'Feel free to add some cheese on top of the finished dish'),
  const Model(
      id: 'm3',
      categories: [
        'c3',
      ],
      title: 'GATED RECURRENT UNIT',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
      description: 'Boil some water - add salt to it once it boils.'
          'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.'
          'In the meantime, heaten up some olive oil and add the cut onion.'
          'After 2 minutes, add the tomato pieces, salt, pepper and your other spices'
          'The sauce will be done once the spaghetti are.'
          'Feel free to add some cheese on top of the finished dish'),
];
