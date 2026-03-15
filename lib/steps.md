1- setup flutter_stripe

2- create customer (optional)
# to return CustomerId

3- createEphemeralKey (CustomerId) (optional)
# to return Ephemeral Key

4- Create a PaymentIntent (amount , currency, customerId)
# to return client Secret

5- Integrate the Payment Sheet (paymentIntentClientSecret, customerId,customerEphemeralKeySecret, merchantDisplayName)
# to show the sheet 

6- display payment sheet 
# to display the sheet 

## step 2 , 3 to save user card 