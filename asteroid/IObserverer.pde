interface IObserverer
{
    void AddCollidable(Actor obj);
    private void CallCollisionMethods(){}
    private void TestCollision(Actor obj){}
}