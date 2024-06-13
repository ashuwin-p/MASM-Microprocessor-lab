int buzzPin = 12;
int trigPin = 11;
int echoPin = 13;

void setup()
{
    pinMode(buzzPin, OUTPUT);
    pinMode(echoPin, INPUT);
    pinMode(trigPin, OUTPUT);
    Serial.begin(9600);
}

void loop()
{
    digitalWrite(trigPin, HIGH);
    delay(1000);
    digitalWrite(trigPin, LOW);

    float duration = pulseIn(echoPin, HIGH);
    float distance = (duration * 0.034) / 2;

    if (distance <= 50 && distance >= 0)
    {
        digitalWrite(buzzPin, HIGH);
        delay(500);
    }
    else
    {
        digitalWrite(buzzPin, LOW);
        delay(500);
    }
}
