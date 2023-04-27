class IntroHelper {
  getImage(int i) {
    return 'assets/images/intro${i + 1}.png';
  }

  geTitle(int i) {
    List title = [
      "We Bring Your Home Appliances Back to Life",
      "Protect Your Home",
      "Just Relax"
    ];
    return title[i];
  }

  geSubTitle(int i) {
    List subTitle = [
   "Get Trusted- Professional-Experienced Experts at your Doorstep",
      "Environmental - Friendly Pest Control Services",
      "We Value for your Time & Money"
    ];
    return subTitle[i];
  }
}
