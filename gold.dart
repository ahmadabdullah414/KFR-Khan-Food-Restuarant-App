import 'package:flutter/material.dart';


class GoldApp extends StatefulWidget {
  const GoldApp({super.key});

  @override
  State<GoldApp> createState() => _GoldAppState();
}

class _GoldAppState extends State<GoldApp> {
  TextEditingController tolaPrice=TextEditingController();
  TextEditingController TolaQuantityController=TextEditingController();
  TextEditingController MashaQuantityController=TextEditingController();
  TextEditingController RattiQuantityController=TextEditingController();
  double totalPrie=0;
  double Price1=0;
  double Price2=0;
  double Price3=0;
  double tola=0;
  double masha=0;
  double ratti=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle:true,
        title: Text('Gold App',style: TextStyle(color: Colors.yellow),),


      ),
      body:
      SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child:
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: Text("1 Tola = 12 Masha = 96 Ratti = 11.664 grams",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
              ),
            ),
          ),

          Text('Enter tola price:',style: TextStyle(color: Colors.white),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.yellow,)
            ),
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.arrow_right_outlined,color: Colors.yellow,),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.white,),
                    controller:  tolaPrice,
                  ),
                )
            ),
          ),
          Text('Price List',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
          Divider(thickness: 2,color:Colors.yellow,),
Row(
mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text('Swipe ',style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w900,fontSize: 18),),
    ),
    Icon(Icons.arrow_forward,color: Colors.yellow,),
  ],
),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      child:

                      Text('1 Tola = $tola Rs',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        child:
                        Text("1 Masha = $masha Rs",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20,vertical: 5),
                        child: Text("1 Ratti = $ratti Rs",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(thickness: 2,color:Colors.yellow,),

          SizedBox(height: 5,),
          Text('Enter Tola Quantity:',style: TextStyle(color: Colors.white),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.yellow,)
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.arrow_right_outlined,color: Colors.yellow,),

                    border: InputBorder.none,
                  ),

                  controller:  TolaQuantityController,
                  style: TextStyle(color: Colors.white),

                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text('Enter Masha Quantity:',style: TextStyle(color: Colors.white),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.yellow,)
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.arrow_right_outlined,color: Colors.yellow,),

                    border: InputBorder.none,
                  ),

                  controller:  MashaQuantityController,
                  style: TextStyle(color: Colors.white),

                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text('Enter Ratti Quantity:',style: TextStyle(color: Colors.white),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.yellow,)
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.arrow_right_outlined,color: Colors.yellow,),

                    border: InputBorder.none,
                  ),

                  controller:  RattiQuantityController,
                  style: TextStyle(color: Colors.white),

                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Calculate',style:TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
          ),
          FloatingActionButton(
            child: Icon(Icons.touch_app_outlined),
            onPressed: (){
              Price1=double.parse(TolaQuantityController.text)*tola;
              Price2=double.parse(MashaQuantityController.text)*masha;
              Price3=double.parse(RattiQuantityController.text)*ratti;
              totalPrie= Price1+Price2+Price3;
              tola = double.parse(tolaPrice.text)/1;
              masha = double.parse(tolaPrice.text)/12;
              ratti = double.parse(tolaPrice.text)/96;



              setState(() {

              });
            },backgroundColor: Colors.yellow,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Total Price:',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:50,),
            child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.yellow)
                ),

                child: Center(child: Text('$totalPrie',style: TextStyle(color: Colors.yellow),))),
          ),
        ],),
      ),
    );
  }
}
