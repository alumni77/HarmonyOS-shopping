// productStore.ts
import set from '../interface/setInterface';
export const productStore: set[] = [];

// productStore.ts
export function addProduct(product: set) {
  productStore.push(product);
}