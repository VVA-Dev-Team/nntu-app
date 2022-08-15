List<int> getBuildings() {
  List<int> buildings = [1, 2, 3, 4, 5, 6];

  return buildings;
}

List<int> getFloors(int buildingNumber) {
  final buildingFloors = [
    [1, 2, 3],
    [1, 2, 3],
    [1, 2, 3],
    [1, 2, 3, 4],
    [1, 2, 3, 4],
    [0, 1, 2, 3, 4, 5]
  ];

  return buildingFloors[buildingNumber - 1];
}
