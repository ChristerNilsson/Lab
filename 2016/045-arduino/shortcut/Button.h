class Button {
  private:
    int pin;
    int lastState;
  public:
    Button(int pin);
    int getValue();
};


