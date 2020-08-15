import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends  StatefulWidget {
  static const routeName='/filters';

  final Function saveFilters;
  final Map<String,bool> currenrFilters;

  FiltersScreen( this.currenrFilters,this.saveFilters);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree=false;
  bool _vegetarian=false;
  bool _vegan=false;
  bool _lactoseFree=false;
  @override
  void initState() {
    // TODO: implement initState
    _glutenFree=widget.currenrFilters['gluten'];
    _lactoseFree=widget.currenrFilters['lactose'];
    _vegan=widget.currenrFilters['vegan'];
    _vegetarian=widget.currenrFilters['vegetarian'];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              final _filters={
                'gluten':_glutenFree,
                'lactose':_lactoseFree,
                'vegan':_vegan,
                'vegetarian':_vegetarian,
              };
              widget.saveFilters(_filters);
              },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child:Text('Adjust your meal selection',style: Theme.of(context).textTheme.title,),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile('Gluten-free','Only include gluten-free meal',_glutenFree,(newValue){
                  setState(() {
                    _glutenFree=newValue;
                  });
                }),
                _buildSwitchListTile('Vegetarian','Only include vegetarian meal',_vegetarian,(newValue){
                  setState(() {
                    _vegetarian=newValue;
                  });
                }),
                _buildSwitchListTile('lactose-free','Only include lactose-free meal',_lactoseFree,(newValue){
                  setState(() {
                    _lactoseFree=newValue;
                  });
                }),
                _buildSwitchListTile('Vegan','Only include vegan meal',_vegan,(newValue){
                  setState(() {
                    _vegan=newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(String title,String description,bool currentValue,Function updateValue) {
    return SwitchListTile(
                title: Text(title),
                subtitle: Text(description),
                value: currentValue,
                onChanged:updateValue,
              );
    }
}
