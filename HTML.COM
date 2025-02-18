import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ShoppingCart, Shirt } from "lucide-react";

const products = [
  { id: 1, name: "T-Shirt", price: 20, image: "/images/tshirt.jpg" },
  { id: 2, name: "Jeans", price: 40, image: "/images/jeans.jpg" },
  { id: 3, name: "Jacket", price: 60, image: "/images/jacket.jpg" },
];

export default function ClothingStore() {
  const [cart, setCart] = useState([]);

  const addToCart = (product) => {
    setCart([...cart, product]);
  };

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4 flex items-center gap-2">
        <Shirt /> Clothing Store
      </h1>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {products.map((product) => (
          <Card key={product.id} className="p-4">
            <img src={product.image} alt={product.name} className="w-full h-40 object-cover rounded" />
            <CardContent className="mt-2">
              <h2 className="text-lg font-semibold">{product.name}</h2>
              <p className="text-gray-600">${product.price}</p>
              <Button className="mt-2" onClick={() => addToCart(product)}>
                Add to Cart
              </Button>
            </CardContent>
          </Card>
        ))}
      </div>
      <div className="mt-6 p-4 border rounded shadow">
        <h2 className="text-xl font-bold mb-2 flex items-center gap-2">
          <ShoppingCart /> Cart
        </h2>
        {cart.length === 0 ? (
          <p>Your cart is empty.</p>
        ) : (
          <ul>
            {cart.map((item, index) => (
              <li key={index} className="flex justify-between border-b py-2">
                {item.name} - ${item.price}
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}
