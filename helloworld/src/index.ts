import express, { Request, Response } from 'express';

const app = express();
const port = 3000;

app.use(express.json());

app.get('/', (req: Request, res: Response) => {
  res.send('Hello, world!');
});

app.get('/api/items', (req: Request, res: Response) => {
  res.json([{ id: 1, name: 'Item 1' }, { id: 2, name: 'Item 2' }]);
});

app.post('/api/items', (req: Request, res: Response) => {
  const newItem = req.body;
  res.status(201).json(newItem);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});