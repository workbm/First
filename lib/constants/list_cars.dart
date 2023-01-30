import '../models/car.dart';

class ListCars {
  static final cars = [
    Car(
      id: 1,
      name: 'Tesla model 3',
      image:
          'https://cdn.breakit.se/assets/article/fa2bf09cffaf76b442517a21ccc56b5c.jpg',
      type: 'Sedan',
      price: 'AED 599 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 50',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Tesla Model 3 is a fully electric four-door sedan manufactured by Tesla, Inc. It was first introduced in 2017 and has since become one of the best-selling electric cars in the world. The car has a sleek and modern design, with a range of up to 358 miles on a single charge.',
    ),
    Car(
      id: 2,
      name: 'Chevrolet Camaro',
      image:
          'https://cdn.automobile-propre.com/uploads/2018/10/chevrolet-camaro-electrique-ecopo-01.jpg',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '2 day rental available',
        'Deposit: AED 300',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
  ];

  static final sportCars = [
    Car(
      id: 1,
      name: 'Ferrari Laferrari',
      image:
          'https://ag-spots-2018.o.auroraobjects.eu/2018/06/17/ferrari-laferrari-c106217062018184712_1.jpg',
      type: 'Sedan',
      price: 'AED 2699 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 5000',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
    Car(
      id: 2,
      name: 'Lamborghini Aventador',
      image:
          'https://cdn.motor1.com/images/mgl/B43Am/s4/2017-lamborghini-aventador-s.jpg',
      type: 'Sedan',
      price: 'AED 1599 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 3000',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
    Car(
      id: 3,
      name: 'McLaren P1',
      image: 'https://www.breezcar.com/img-c/pageimg/2981_W750.jpg',
      type: 'Sedan',
      price: 'AED 1399 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 5000',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
  ];

  static final luxuryCar = [
    Car(
      id: 2,
      name: 'Cadillac CT4 V',
      image:
          'https://static.tcimg.net/vehicles/oem/b1a1f917370c928c/2023-Cadillac-CT4-V.jpg?fit=crop&h=514.9464668094218&w=720',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 200',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
    Car(
      id: 2,
      name: 'Mercedes Maybach S680',
      image:
          'https://www.biegowelove.pl/wp-content/uploads/2021/06/2021-Mercedes-Maybach-Klasa-S-S680-Recenzja-1024x682.jpg',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 250',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
    Car(
      id: 2,
      name: 'BMW 7 Series',
      image:
          'https://static.tcimg.net/vehicles/oem/25d60abf704dbe95/2023-BMW-7_Series.jpg?fit=crop&h=514.9464668094218&w=720',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 90',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
  ];

  static final suvCars = [
    Car(
      id: 2,
      name: 'Volvo xc40',
      image:
          'https://guide.autoscout24.ch/wp-content/uploads/2022/07/suv_2022_volvo-xc40-recharge_autoscout24-6-768x432.jpg',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 90',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
    Car(
      id: 2,
      name: 'Mercedes Maybach GLS',
      image:
          'https://i.gaw.to/content/photos/37/11/371104_Le_Mercedes-Maybach_GLS_sera_le_vehicule_le_plus_cher_produit_en_Amerique.jpg',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 90',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
    Car(
      id: 2,
      name: 'Bentley Bentayga',
      image:
          'https://media.ed.edmunds-media.com/bentley/bentayga/2018/oem/2018_bentley_bentayga_4dr-suv_mulliner_fq_oem_1_815.jpg',
      type: 'Sedan',
      price: 'AED 999 / day 250 km',
      options: [
        '1 day rental available',
        'Deposit: AED 90',
        'Insurance included',
        'Free delivery',
      ],
      description:
          'The Chevrolet Camaro offers several benefits to its drivers, including high performance, stylish design, versatility, advanced technology, high-performance handling and powerful engine options.',
    ),
  ];

  static const vectorAssetList = [
    'assets/images/vector14.png',
    'assets/images/vector13.png',
    'assets/images/seat2.png',
    'assets/images/group.png',
  ];
}
